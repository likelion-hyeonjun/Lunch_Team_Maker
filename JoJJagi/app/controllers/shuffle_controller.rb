class ShuffleController < ApplicationController
  def index
  end

  def shuffle

    @jo = []

    for i in 1..4
      @jo[i] = Jo.create(description:"#{i}조")
    end

    index = Random.new.rand(0..3)
    @jo[index+1].users.push(User.where(name:"찬").first)
    @jo[(index+3)%4+1].users.push(User.where(name:"찰리").first)#찰리 찬은 서로다른곳에 고정

    index = 0
    for i in 0..2
      User.where(team_cd:i).shuffle.each do |u0|
        if(u0.name != '엘런')
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
      u.jo_id = 1 #기본적으로 다시 전체 리스트에 포함되도록 설정
    end
    redirect_to '/shuffle/index'
  end
end
