require 'lerolero_generator'
namespace :dev do

  desc "Setup Development"
  task setup: :environment do
    images_path = Rails.root.join('public','system')

    puts "Executando o setup para desenvolvimento..."
      puts "Rodando drop #{%x(rake db:drop)}"
      puts "Rodando create #{%x(rake db:create)}"
      puts "Rodando migrate #{%x(rake db:migrate)}"
      puts "Apagando imagens de public/system  #{%x(rm -rf #{images_path})}"
      puts %x(rake db:seed)
      puts %x(rake dev:generate_admins)
      puts %x(rake dev:generate_members)
      puts %x(rake dev:generate_anuncios)
      puts %x(rake dev:generate_comments)
      puts %x(rake dev:generate_member_default)
  end
  ####################################################################

  desc "Cria administradores fake"
  task generate_admins: :environment do
    puts '********* Criando Administradores Faker *********'
    10.times do
      Admin.create!(email: Faker::Internet.email,
      name: Faker::Name.name,
      password: "123456",
      password_confirmation: "123456",
      role: [0, 1].sample
    )
    end
    puts '********* Administradores criados *********'
  end

  ####################################################################

  desc "Cria membros fake"
  task generate_members: :environment do
    puts '********* Criando membros Faker *********'
    100.times do
      member = Member.new(
      email: Faker::Internet.email,
      password: "123456",
      password_confirmation: "123456"
    )
      member.build_profile_member
      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name

      member.save!

    end
    puts '********* membros criados *********'
  end

  ####################################################################
  desc 'Cria anuncios fake'
  task generate_anuncios: :environment do
    puts '********* Criando anuncios *********'
    
    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public','templates','images-for-ads', "#{Random.rand(4)}.jpg"), 'r')
      )
    end

    100.times do
      Ad.create!(
          title: Faker::Lorem.sentence([2,3,4,5].sample),
          description_md: markdown_fake,
          description_short: Faker::Lorem.sentence([2,3].sample),
          member: Member.all.sample,
          category: Category.all.sample,
          price: "#{Random.rand(500)},#{Random.rand(99)}",
          finish_date: Date.today + Random.rand(90),
          picture: File.new(Rails.root.join('public','templates','images-for-ads', "#{Random.rand(4)}.jpg"), 'r')
      )
    end
    puts "********* Anuncios cadastrados com sucesso *********"
  end

  ######################################################################
  desc "Cria membro padrao"
  task generate_member_default: :environment do
    puts '********* Criando membro padrao *********'
     member = Member.new(
      email: "membro_default@default.com",
      password: "123456",
      password_confirmation: "123456"
    )

    member.build_profile_member
    member.profile_member.first_name = Faker::Name.first_name
    member.profile_member.second_name = Faker::Name.last_name

    member.save!
    puts '********* membro padrao criado *********'
  end

  def markdown_fake
    # Refatorar usando a gem diretamente
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end

  #######################################################################

  desc "Cria comentarios fake"
  task generate_comments: :environment do
    puts '********* Criando comentarios Faker *********'

    Ad.all.each do |ad|
      (Random.rand(3)).times do
        Comment.create!(
             body: Faker::Lorem.paragraph([1, 2, 3].sample),
             member: Member.all.sample,
             ad: ad
        )
      end
    end

    puts "********* comentarios cadastrados com sucesso *********"
  end

end
