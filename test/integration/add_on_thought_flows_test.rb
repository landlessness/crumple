require 'test_helper'

class AddOnThoughtFlowsTest < ActionDispatch::IntegrationTest
  fixtures :all

  # Replace this with your real tests.
  test 'get list of music notation thoughts' do
    get '/music_notation_thoughts/1'
    # assert_response :success
    assert t = assigns(:thought)
    assert_equal 'X:1
    T:Speed the Plough
    M:4/4
    C:Trad.
    K:G
    |:GABc dedB|dedB dedB|c2ec B2dB|c2A2 A2BA|
      GABc dedB|dedB dedB|c2ec B2dB|A2F2 G4:|
    |:g2gf gdBd|g2f2 e2d2|c2ec B2dB|c2A2 A2df|
      g2gf g2Bd|g2f2 e2d2|c2ec B2dB|A2F2 G4:|', t.body
  end
end
