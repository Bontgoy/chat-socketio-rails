require 'rails_helper'

RSpec.describe 'ChatRooms API', type: :request do
  # initialize test data
  let!(:created) { create(:user) }
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }
  let!(:chat_rooms) { create_list(:chat_room, 10, created_id: created.id, \
                              sender_id: sender.id, recipient_id: recipient.id) }
  let(:chat_room_id) { chat_rooms.first.id }

  # Test suite for GET /chat_rooms
  describe 'GET /chat_rooms' do
    # make HTTP get request before each example
    before { get '/chat_rooms' }

    it 'returns chat rooms' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /chat_rooms/:id
  describe 'GET /chat_rooms/:id' do
    before { get "/chat_rooms/#{chat_room_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(chat_room_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:chat_room_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find ChatRoom/)
      end
    end
  end

  # Test suite for POST /chat_rooms
  describe 'POST /chat_rooms' do
    # valid payload
    let(:valid_attributes) { { title: 'Learn Elm', created_id: created.id, \
                               sender_id: sender.id, recipient_id: recipient.id } }

    context 'when the request is valid' do
      before { post '/chat_rooms', params: valid_attributes }

      it 'creates a chat room' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/chat_rooms', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Sender must exist/)
      end
    end
  end

  # Test suite for PUT /chat_rooms/:id
  describe 'PUT /chat_rooms/:id' do
    let(:valid_attributes) { { title: 'Shopping', created_id: created.id, \
                               sender_id: sender.id, recipient_id: recipient.id } }

    context 'when the record exists' do
      before { put "/chat_rooms/#{chat_room_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /chat_rooms/:id
  describe 'DELETE /chat_rooms/:id' do
    before { delete "/chat_rooms/#{chat_room_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end