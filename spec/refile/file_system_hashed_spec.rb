require 'refile/spec_helper'
require 'refile/backend/file_system_hashed'

RSpec.describe Refile::Backend::FileSystemHashed do
  let(:backend) { Refile::Backend::FileSystemHashed.new('tmp', max_size: 100) }

  it_behaves_like :backend

  describe '#path' do
    let(:orginal_backend) { Refile::Backend::FileSystem.new('tmp', max_size: 100) }
    let(:uploadable) { Refile::FileDouble.new('hello') }

    it 'generates a hashed path based on the first 8 characters given id' do
      id = '0601ae4450cdc210ab9d05da50c392ee1c4b1894e8b2bc9cc5cc9e41e691'
      expect(backend.path(id)).to eq(::File.join(backend.directory, '06', '01', 'ae', '44', id))
    end

    it 'automagically moves files created with the standard FileSystem backend to the new hashed directory structure' do
      file = orginal_backend.upload(uploadable)

      backend.path(file.id)

      expect(backend.exists?(file.id)).to be_truthy
      expect(backend.read(file.id)).to eq('hello')
      expect(orginal_backend.exists?(file.id)).to be_falsy
    end
  end
end
