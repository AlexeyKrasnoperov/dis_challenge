require 'rails_helper'

RSpec.describe RoutesController, type: :controller do
  let!(:sentinels_route_1) { FactoryGirl.create(:route, data_source: :sentinels) }
  let!(:sentinels_route_2) { FactoryGirl.create(:route, data_source: :sentinels) }
  let!(:sniffers_route) { FactoryGirl.create(:route, data_source: :sniffers) }
  let!(:loopholes_route) { FactoryGirl.create(:route, data_source: :loopholes) }

  PASSPHRASE = 'Kans4s-i$-g01ng-by3-bye'

  describe '#index' do
    it 'responses with correct data' do
      get :index, params: { source: :sentinels }
      expect(assigns(:routes)).to contain_exactly(sentinels_route_1, sentinels_route_2)
      expect(response).to have_http_status(:ok)
      expect(json).to match_json_schema('routes/index')
    end

    it 'returns error if no source passed' do
      expect { get :index }.to raise_error(BadRequestError, 'Source can\'t be blank')
    end

    it 'returns error for incorrect source' do
      expect { get :index, params: { source: :mr_smith } }
        .to raise_error(BadRequestError, 'Source is not included in the list')
    end
  end

  describe '#create' do
    it 'responses with correct status' do
      post :create, params: {
        passphrase: PASSPHRASE,
        source: :sentinels,
        start_node: :alpha,
        end_node: :beta,
        start_time: '2016-11-20T16:00:00',
        end_time: '2016-11-21T01:15:00'
      }

      expect(response).to have_http_status(:no_content)
    end

    it 'changes Routes count' do
      expect do
        post :create, params: {
          passphrase: PASSPHRASE,
          source: :sentinels,
          start_node: :alpha,
          end_node: :beta,
          start_time: '2016-11-20T16:00:00',
          end_time: '2016-11-21T01:15:00'
        }
      end.to change { Route.count }.by(1)
    end

    it 'returns error for incorrect passphrase' do
      expect do
        post :create, params: {
          passphrase: 'incorrect_passphrase',
          source: :sentinels,
          start_node: :alpha,
          end_node: :beta,
          start_time: '2016-11-20T16:00:00',
          end_time: '2016-11-21T01:15:00'
        }
      end.to raise_error(BadRequestError, 'Passphrase is not included in the list')
    end

    it 'returns error if not all mandatory params passed' do
      expect do
        post :create, params: {
          passphrase: PASSPHRASE,
          start_node: :alpha,
          end_node: :beta,
          start_time: '2016-11-20T16:00:00',
          end_time: '2016-11-21T01:15:00'
        }
      end.to raise_error(BadRequestError, 'Source can\'t be blank')
    end

    it 'returns error for incorrect params' do
      expect do
        post :create, params: {
          passphrase: PASSPHRASE,
          source: :mr_smith,
          start_node: :alpha,
          end_node: :beta,
          start_time: '2016-11-20T16:00:00',
          end_time: '2016-11-21T01:15:00'
        }
      end.to raise_error(BadRequestError, 'Source is not included in the list')
    end
  end
end
