# This data can then be loaded with the rails db:seed command (or created alongside the database with db:setup), and reseeded with db:reset

harry = User.create_with(name: "HarryPotter", password: "hedwigrules").find_or_create_by!(email: "harry@hogwarts.com")

ron = User.create_with(name: "RonWeasley", password: "quidditch4life").find_or_create_by!(email: "ron@hogwarts.com")

hermione = User.create_with(name: "HermioneGranger", password: "schoolis4eva").find_or_create_by!(email: "hermione@hogwarts.com")

voldemort = User.create_with(name: "Voldemort", password: "thedarkmark").find_or_create_by!(email: "voldy@deatheaters.com")

bellatrix = User.create_with(name: "BellatrixLestrange", password: "ilovevoldy").find_or_create_by!(email: "bella@deatheaters.com")

chirp_1 = Chirp.create(author: harry, content: "First Chirp! Hi friends!")
chirp_2 = Chirp.create(author: ron, content: "Can't wait for the quidditch world cup!!!!!")
chirp_3 = Chirp.create(author: hermione, content: "I am rather excited for exams, if only @RonWeasley could focus.")
chirp_4 = Chirp.create(author: ron, content: "I'm focusing on the important things in life, @HermioneGranger.")
chirp_5 = Chirp.create(author: bellatrix, content: "Off to do some super secret death eater business!")
chirp_6 = Chirp.create(author: voldemort, content: "Who wants to join my @HarryPotter hunt? 😎")
chirp_7 = Chirp.create(author: harry, content: "Wait, what did @Voldemort just say?")
