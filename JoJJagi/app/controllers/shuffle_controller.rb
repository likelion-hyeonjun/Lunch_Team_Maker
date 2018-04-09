class ShuffleController < ApplicationController
  def index
  end

  def shuffle
    @jo1 = Jo.create( description:"1조")
    @jo2 = Jo.create( description:"2조")
    @jo3 = Jo.create( description:"3조")
    @jo4 = Jo.create( description:"4조")
    @jo1.users = User.where(team_cd:0)
    @jo2.users = User.where(team_cd:1)
    @jo3.users = User.where(team_cd:2)
    @jo4.users = User.where(team_cd:3)
  end

  def destroy
    Jo.where('description <> ?','전체 멤버 리스트').destroy_all
    redirect_to '/shuffle/index'
  end
end
