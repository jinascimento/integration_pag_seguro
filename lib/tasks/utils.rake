namespace :utils do

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

end
