require File.expand_path '../spec_helper.rb', __dir__

describe Company, :vcr do
  describe '#initialize' do
    it 'correctly creates the company object' do
      @company = Company.new(
        id: 1,
        uuid: 123,
        legal_name: 'NOME',
        logo: 'logo.png',
        description: 'description',
        phone: 'phone',
        type: 'tipo',
        estimated_annual_revenue: '1b'
      )

      expect(@company.id).to eq(1)
      expect(@company.uuid).to eq(123)
      expect(@company.legal_name).to eq('NOME')
      expect(@company.logo).to eq('logo.png')
      expect(@company.description).to eq('description')
      expect(@company.phone).to eq('phone')
      expect(@company.type).to eq('tipo')
    end
  end

  describe '.find_by_name' do
    it 'retrieves a company object with the correct company info' do
      VCR.use_cassette('company_model_find_by_name', record: :new_episodes) do
        @company = Company.find_by_name('Uber')

        expect(@company.id).to eq('Uber')
        expect(@company.uuid).to eq('3f5d6a4e-c284-4f78-bfdf-7669b45af907')
        expect(@company.legal_name).to eq('Uber Technologies Inc.')
        expect(@company.logo).to eq("https:\/\/logo.clearbit.com\/uber.com")
        expect(@company.description).to eq('Get a ride in minutes. Or become a driver-partner and earn money on your schedule. Uber is finding you better ways to move, work, and get ahead.')
        expect(@company.phone).to eq('+1 415-986-2104')
        expect(@company.type).to eq('private')
      end
    end
  end
end
