require 'spec_helper'

describe GameWindow do 
  it 'works with no config' do
    GameWindow.new.should_not be_nil
  end
end