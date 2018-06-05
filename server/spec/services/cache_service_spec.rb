require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe CacheService do
  describe '.get' do
    context 'when key exists in redis' do
      it 'returns the parsed value ' do
        allow_any_instance_of(Redis).to receive(:get).and_return('{"key":"value"}')
        expect(CacheService.get('key')).to eq('key' => 'value')
      end
    end

    context 'when key does not exist in redis' do
      it 'returns nil' do
        allow_any_instance_of(Redis).to receive(:get).and_return(nil)
        expect(CacheService.get('key')).to eq(nil)
      end
    end
  end

  describe '.expire' do
    context 'when key is set in redis' do
      it 'calls expire with the constant value of time expiration' do
        expect_any_instance_of(Redis).to receive(:expire).with('key', CacheService::CACHING_TIME_IN_SECONDS)
        CacheService.set('key', 'value')
      end
    end
  end
end
