class ShuffleController < ApplicationController
  def index
  end

  def shuffle
    @arr = []
    @jo = []
    @user = User.all
    for i in 1..4
      @jo[i] = Jo.create(description:"#{i}조")
    end
    index = Random.new.rand(0..3)
    @jo[index+1].users.push(User.where(name:"찬").first)
    index = Random.new.rand(0..3)
    @jo[index+1].users.push(User.where(name:"찰리").first) #최대 6, 최소 4가나옴. 잘못하면 7까지도 나올수있음.. 리사 엘런이 붙어야하므로..
    index = 0
    for i in 0..2
      User.where(team_cd:i).shuffle.each do |u0|
        @jo[(index%4+1)].users.push(u0)
        index += 1
      end
    end #shuffle 다됨


  end

  def destroy
    Jo.where('description <> ?','전체 멤버 리스트').destroy_all
    User.all.each do |u|
      u.jo_id = 1 #기본적으로 다시 전체 리스트에 포함되도록 설정
    end
    redirect_to '/shuffle/index'
  end
end
