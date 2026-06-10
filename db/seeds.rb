# This data can then be loaded with the rails db:seed command (or created alongside the database with db:setup), and reseeded with db:reset

mario = User.create_with(name: "Mario", password: "itsame-mario").find_or_create_by!(email: "mario@mushroomkingdom.com")

luigi = User.create_with(name: "Luigi", password: "green-stache").find_or_create_by!(email: "luigi@mushroomkingdom.com")

peach = User.create_with(name: "Peach", password: "toadstool-princess").find_or_create_by!(email: "peach@mushroomkingdom.com")

bowser = User.create_with(name: "Bowser", password: "koopa-king").find_or_create_by!(email: "bowser@koopatroop.com")

koopa_troopa = User.create_with(name: "KoopaTroopa", password: "shell-shuffle").find_or_create_by!(email: "koopa.troopa@koopatroop.com")

chirp_1 = Chirp.create(author: mario, content: "First Chirp! Hi friends!")
chirp_2 = Chirp.create(author: luigi, content: "Can't wait for the Mario Kart Grand Prix!!!!!")
chirp_3 = Chirp.create(author: peach, content: "I am rather excited for royal duties, if only @Luigi could focus.")
chirp_4 = Chirp.create(author: luigi, content: "I'm focusing on the important things in life, @Peach.")
chirp_5 = Chirp.create(author: koopa_troopa, content: "Off to do some super secret Koopa Troop business!")
chirp_6 = Chirp.create(author: bowser, content: "Who wants to join my @Mario hunt? 😎")
chirp_7 = Chirp.create(author: mario, content: "Wait, what did @Bowser just say?")

mario.followers << luigi
mario.followers << peach
mario.followers << bowser

luigi.followers << mario
luigi.followers << peach

peach.followers << mario
peach.followers << luigi

bowser.followers << koopa_troopa
