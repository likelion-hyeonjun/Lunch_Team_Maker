require 'net/http'
require 'uri'
require 'json'
class ShuffleController < ApplicationController
  before_action :set_user, only:[:edit]
  def index
  end

  def change
    User.find_by_name(params[:name]).update(vacation: params[:vacation])
    redirect_to '/shuffle/index'
  end

  def shuffle
    Jo.where('description <> ?','전체 멤버 리스트').destroy_all
    User.all.each do |u|
      if u.leader
        u.update(:leader => nil)
      end #조장값 초기화
      Jo.first.users.push(u)
    end #이부분 코드 중복 ㅠㅠ 어떻게든 고칠수있을거같은데 오류떠서 무서워서 못고치겟다

    @jo = []

    for i in 1..4
      @jo[i] = Jo.create(description:"#{i}조")
    end

    loop do
      index = Random.new.rand(0..3)
        if(!User.find_by(name:'찬').vacation)
          @jo[index+1].users.push(User.where(name:"찬").first)
        end
        if(!User.find_by(name:'찰리').vacation)
          @jo[(index+3)%4+1].users.push(User.where(name:"찰리").first)#찰리 찬은 서로다른곳에 고정
        end

      index = 0
      for i in 0..3
       User.where(team_cd:i, vacation:nil).shuffle.each do |u0|
         if(u0.name != '엘런')
           @jo[(index%4+1)].users.push(u0)
           index += 1
         end
       end
      end #shuffle과정 엘런은 제약이있기때문에 일단 뺴놓음


      #엘런 조에 랜덤하게 추가, 리사가 휴가일때와 아닐때를 구분해서 추가함
     if !User.find_by(name:'엘런').vacation? #엘런이 휴가중 아닐때만
        if User.find_by(name:'리사').vacation? #리사 휴가중일때 / 로직이 리사가 휴가중이라면 엘런도 아만다 서버팀에 맞춰 랜덤하게 들어가야 할텐데
          elleon = User.find_by(name:'엘런')
         @jo[index%4+1].users.push(elleon)
        else #리사 휴가중아닐때
          for i in 1..4
            if @jo[i].users.exists?(:name=>'리사')
               @jo[i].users.push(User.find(23))
            end
          end #리사가 있는 조에 엘런 추가
        end
      end

      jo_length = [@jo[1].users.length , @jo[2].users.length , @jo[3].users.length , @jo[4].users.length]
      break if (jo_length.max - jo_length.min < 3)

      for i in 1..4
        @jo[i].users = []
      end

    end

    for i in 1..4
        @jo[i].users.sample.update(leader: true)
    end #랜덤하게 조장뽑기


  end

  def destroy
    Jo.where('description <> ?','전체 멤버 리스트').destroy_all
    User.all.each do |u|

        if u.leader
          u.leader = nil
        end #조장값 초기화

      Jo.first.users.push(u)
    end
    redirect_to '/shuffle/index'
  end

  def sendslack
    json = ""
    Jo.where("id<>1").each do |j|
      json += "#{j.description} :\n"
          j.users.each do |u|
          if u.leader
            json +="<조장: #{u.name}>  "
         else
           json +="'#{u.name}'  "
         end
        end
      json += "\n"
    end

    uri = URI.parse("https://hooks.slack.com/services/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")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request.body = JSON.dump({   "username" => "delicious_lunch_bot",
                                 "icon_emoji" => ":hamburger:",
                                 "text"=> "@channel",
                                 "attachments": [
                                 {
                                     "fallback":"",
                                     "title": "오늘 점심을 같이 먹을 동료들입니다.",
                                     "text": "#{json}",
                                     "color": "#7CD197"
                                 }
    ]})
    req_options = {
        use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
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
