# frozen_string_literal: true

require 'test_helper'

class ActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @action = actions(:one)
  end

  test 'should get index' do
    get actions_url, as: :json
    assert_response :success
  end

  test 'should create action' do
    assert_difference('Action.count') do
      post actions_url,
           params: { action: { game_id: @action.game_id, player_id: @action.player_id, success: @action.success, target_player_id: @action.target_player_id, type: @action.type } }, as: :json
    end

    assert_response :created
  end

  test 'should show action' do
    get action_url(@action), as: :json
    assert_response :success
  end

  test 'should update action' do
    patch action_url(@action),
          params: { action: { game_id: @action.game_id, player_id: @action.player_id, success: @action.success, target_player_id: @action.target_player_id, type: @action.type } }, as: :json
    assert_response :success
  end

  test 'should destroy action' do
    assert_difference('Action.count', -1) do
      delete action_url(@action), as: :json
    end

    assert_response :no_content
  end
end
