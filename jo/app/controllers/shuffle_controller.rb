class ShuffleController < ApplicationController
  before_action :set_user, only:[:edit]

  def index
  end

  def change
    User.find_by_name(params[:name]).update(vacation: params[:vacation])
    redirect_to '/shuffle/index'
  end

  def shuffle

    @jo = []

    for i in 1..4
      @jo[i] = Jo.create(description:"#{i}조")
    end

    index = Random.new.rand(0..3)
    if(!User.find_by(name:'찬').vacation)
      @jo[index+1].users.push(User.where(name:"찬").first)
    end
    if(!User.find_by(name:'찰리').vacation)
      @jo[(index+3)%4+1].users.push(User.where(name:"찰리").first)#찰리 찬은 서로다른곳에 고정
    end

    index = 0
    for i in 0..2
      User.where(team_cd:i).shuffle.each do |u0|
        if(u0.name != '엘런' && !u0.vacation)
          @jo[(index%4+1)].users.push(u0)
          index += 1
        end
      end
    end #shuffle과정 엘런은 제약이있기때문에 일단 뺴놓음

    for i in 1..4
      if @jo[i].users.exists?(:name=>'리사')
        @jo[i].users.push(User.find(23))
      end
    end #리사가 있는 조에 엘런 추가

  end

  def destroy
    Jo.where('description <> ?','전체 멤버 리스트').destroy_all
    User.all.each do |u|
      Jo.first.users.push(u)
    end
    redirect_to '/shuffle/index'
  end


  def edit
  end

  private

  def set_user
    @users = User.find(params[:format])
  end
end
