require 'spec_helper'

describe Api::ApiController do
  describe '#index' do
    let(:query) { get :index, format: :json }
    let(:json) { JSON.parse(response.body) }
    subject { query; json }

    describe 'JSON' do
      subject { query; json }

      it { should have_key('sessions_url') }
      it { should have_key('posts_url') }
      it { should have_key('users_url') }
    end
  end
end
