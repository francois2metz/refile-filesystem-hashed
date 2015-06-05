module Refile
  module Backend
    class FileSystemHashed < FileSystem
      verify_uploadable def upload(uploadable)
        id = @hasher.hash(uploadable)
        path = path(id)
        FileUtils.mkdir_p(::File.dirname(path))
        IO.copy_stream(uploadable, path)

        Refile::File.new(self, id)
      end

      verify_id def exists?(id)
        return true if ::File.exist?(path(id))

        if ::File.exist?(original_path(id))
          FileUtils.mkdir_p(::File.dirname(path(id)))
          FileUtils.mv(original_path(id), path(id))
          return true
        end

        false
      end

      verify_id def path(id, create = false)
        ::File.join(@directory, id.scan(/.{2}/).first(4), id)
      end

      verify_id def original_path(id)
        ::File.join(@directory, id)
      end
    end
  end
end
