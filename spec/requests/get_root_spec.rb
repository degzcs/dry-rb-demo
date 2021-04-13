require 'spec_helper'

RSpec.describe 'GET /', type: :request do
  let(:app) { Api.new }
  let(:response) { get '/' }
  it 'should be 200 OK' do
    expect(response.status).to eq 200
  end
end
