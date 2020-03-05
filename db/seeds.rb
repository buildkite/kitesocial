# This data can then be loaded with the rails db:seed command (or created alongside the database with db:setup), and reseeded with db:reset

harry = User.create_with(name: "Harry Potter", password: "hedwigrules").find_or_create_by!(email: "harry@hogwarts.com")

ron = User.create_with(name: "Ron Weasley", password: "quidditch4life").find_or_create_by!(email: "ron@hogwarts.com")

hermione = User.create_with(name: "Hermione Granger", password: "schoolis4eva").find_or_create_by!(email: "hermione@hogwarts.com")

voldemort = User.create_with(name: "Voldemort", password: "thedarkmark").find_or_create_by!(email: "voldy@deatheaters.com")

bellatrix = User.create_with(name: "Bellatrix Lestrange", password: "ilovevoldy").find_or_create_by!(email: "bella@deatheaters.com")

chirp_1 = Chirp.create(author_id: harry.id, content: "First Chirp! Hi friends!")
chirp_2 = Chirp.create(author_id: ron.id, content: "Can't wait for the quidditch world cup!!!!!")
chirp_3 = Chirp.create(author_id: hermione.id, content: "I am rather excited for exams, if only Ronald could focus.")
chirp_4 = Chirp.create(author_id: ron.id, content: "I'm focusing on the important things in life, Hermione.")
chirp_5 = Chirp.create(author_id: bellatrix.id, content: "Off to do some super secret death eater business!")
chirp_6 = Chirp.create(author_id: voldemort.id, content: "Who wants to join my harry hunt? 😎")
chirp_7 = Chirp.create(author_id: harry.id, content: "Wait, what did Voldy just say?")
