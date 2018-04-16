class Amiibo

    attr_reader :id, :character_name, :game_series, :image, :has_been_released

    DB = PG.connect(host: "localhost", port: 5432, dbname: 'amiibo_tracker')

    def initialize(opts = {})
        @id = opts["id"].to_i
        @character_name = opts["character_name"]
        @game_series = opts["game_series"]
        @image = opts["image"]
        @has_been_released = opts["has_been_released"]
    end

    def self.all
        results = DB.exec("select * from amiibo;")
        return results.map { |result| Amiibo.new(result) }
    end

    def self.find(id)
        results = DB.exec("select * from amiibo where id=#{id};")
        return Amiibo.new(results.first)
    end

    def self.create(opts={})
        results = DB.exec(
            <<-SQL
                INSERT INTO amiibo (character_name, game_series, image, has_been_released)
                VALUES ('#{opts["character_name"]}', '#{opts["game_series"]}', '#{opts["image"]}', '#{opts["has_been_released"]}')
                RETURNING id, character_name, game_series, image, has_been_released;
            SQL
        )
        return Amiibo.new(results.first)
    end

    def self.delete(id)
        results = DB.exec("delete from amiibo where id=#{id};")
        return { deleted: true }
    end

    def self.update(id, opts={})
        results = DB.exec(
            <<-SQL
                UPDATE amiibo 
                SET character_name='#{opts["character_name"]}', game_series='#{opts["game_series"]}', image='#{opts["image"]}', has_been_released='#{opts["has_been_released"]}'
                WHERE id=#{id}
                RETURNING id, character_name, game_series, image, has_been_released;
            SQL
        )
        return Amiibo.new(results.first)
    end
end
