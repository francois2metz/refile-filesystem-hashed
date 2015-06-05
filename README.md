# Refile::Backend::FileSystemHashed

Refile backend that's based on `Refile::Backend::FileSystem` and stores files in sub-directories based on the given file id instead of storing all files on one directory.

Refile's out-of-the-box backend `Refile::Backend::FileSystem` stores all files within one directory which can get very large and makes maintenance (`ls`, etc.) very slow. This gem extends the default behavior, it splits up the directory in tiny chunks based on the given file id. For example if there is a file with id `0601ae4450cdc210ab9d05da50c392ee1c4b1894e8b2bc9cc5cc9e41e691` it stores the file in the nested directory `06/01/ae/44/0601ae4450cdc210ab9d05da50c392ee1c4b1894e8b2bc9cc5cc9e41e691` within the given directory.

## Usage

Add `refile-filesystem-hashed` to your Gemfile.

    gem 'refile-filesystem-hashed', '~> 1.0.1', require: 'refile/backend/file_system_hashed'

Replace `Refile::Backend::FileSystem` with `Refile::Backend::FileSystemHashed`.

    backend = Refile::Backend::FileSystemHashed.new("/uploads")
    backend.path('0601ae4450cdc210ab9d05da50c392ee1c4b1894e8b2bc9cc5cc9e41e691')
    => "/uploads/06/01/ae/44/0601ae4450cdc210ab9d05da50c392ee1c4b1894e8b2bc9cc5cc9e41e691"

You can replace `Refile::Backend::FileSystem` at any time as the gem will automagically move existing files to the new hashed directory structure.
