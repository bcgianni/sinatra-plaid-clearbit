require File.expand_path '../spec_helper.rb', __dir__

RSpec.describe ClearbitService::Company do
  describe '.enrich_by_name' do
    context 'when providing a company name' do
      it 'retrieves the correct company object' do
        VCR.use_cassette('clearbit_enrich_by_name', record: :new_episodes) do
          expect(ClearbitService::Company.enrich_by_name('Uber')).to eq(
            description: 'Get a ride in minutes. Or become a driver-partner and earn money on your schedule. Uber is finding you better ways to move, work, and get ahead.',
            id: 'Uber',
            legal_name: 'Uber Technologies Inc.',
            logo: 'https://logo.clearbit.com/uber.com',
            phone: '+1 415-986-2104',
            type: 'private',
            uuid: '3f5d6a4e-c284-4f78-bfdf-7669b45af907'
          )
        end
      end
    end
  end
end
