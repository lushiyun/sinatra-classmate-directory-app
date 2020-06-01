class ClassmatesController < ApplicationController
  before do
    login_required
  end
end