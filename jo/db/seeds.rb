# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Jo.create(id:1, description:'전체 멤버 리스트')

User.create(id:1, name:'찰리', team:'ceo', jo_id:1)
User.create(id:2, name:'찬', team:'ceo',jo_id:1)
User.create(id:3, name:'에릭', team:'common',jo_id:1)
User.create(id:4, name:'엔', team:'common',jo_id:1)
User.create(id:5, name:'저스틴', team:'common',jo_id:1)
User.create(id:6, name:'짐', team:'amanda_server',jo_id:1)
User.create(id:7, name:'조', team:'groove',jo_id:1)
User.create(id:8, name:'알렉스', team:'groove',jo_id:1)
User.create(id:9, name:'오헨리', team:'common',jo_id:1)
User.create(id:10, name:'이더', team:'groove',jo_id:1)
User.create(id:11, name:'레이나', team:'common',jo_id:1)
User.create(id:12, name:'이안', team:'common',jo_id:1)
User.create(id:13, name:'쥬드', team:'groove',jo_id:1)
User.create(id:14, name:'데릭', team:'common',jo_id:1)
User.create(id:15, name:'그렉', team:'common',jo_id:1)
User.create(id:16, name:'리사', team:'groove',jo_id:1)
User.create(id:17, name:'케빈', team:'amanda_server',jo_id:1)
User.create(id:18, name:'헨리', team:'amanda_server',jo_id:1)
User.create(id:19, name:'척', team:'common',jo_id:1)
User.create(id:20, name:'제이', team:'groove',jo_id:1)
User.create(id:21, name:'쿠퍼', team:'groove',jo_id:1)
User.create(id:22, name:'티엠', team:'groove',jo_id:1)
# 엘런은..리사랑같이다니기..
User.create(id:23, name:'엘런', team:'groove',jo_id:1)


