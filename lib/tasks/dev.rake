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
      Member.create!(
      email: Faker::Internet.email,
      password: "123456",
      password_confirmation: "123456"
    )
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
        description: LeroleroGenerator.paragraph(Random.rand(3)),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        picture: File.new(Rails.root.join('public','templates','images-for-ads', "#{Random.rand(4)}.jpg"), 'r')
      )
    end
    puts "********* Anuncios cadastrados com sucesso *********"
  end

  ######################################################################
  desc "Cria membro padrão"
  task generate_member_default: :environment do
    puts '********* Criando membro padrão *********'
      Member.create!(
      email: "membro_default@default.com",
      password: "123456",
      password_confirmation: "123456"
    )
    puts '********* membro padrão criado *********'
  end

end
