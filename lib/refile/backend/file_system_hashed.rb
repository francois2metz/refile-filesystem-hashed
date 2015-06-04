module Refile
  module Backend
    class FileSystemHashed < FileSystem
      verify_id def path(id)
        original_path = ::File.join(@directory, id)
        hashed_path = ::File.join(@directory, id.scan(/.{2}/).first(4), id)

        FileUtils.mkdir_p(::File.dirname(hashed_path))
        FileUtils.mv(original_path, hashed_path) if ::File.exist?(original_path)

        hashed_path
      end
    end
  end
end
