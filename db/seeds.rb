# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Counting.create(title: 'Erste Nacht der Solidarität am 29./30.01.2020', description_short: 'In der Nacht vom 29. auf den 30. Januar 2020 wurden in Berlin erstmals obdachlose Menschen, die nachts auf der Straße schlafen, gezählt und befragt. Berlin folgte damit als erste deutsche Stadt dem Beispiel von Paris und New York.', starts_at: '2020-01-29 22:00:00', ends_at: '2020-01-30 02:00:00', user_id: 15)

Counting.create(title: 'Zweite Nacht der Solidarität am 22./23.06.2022', description_short: 'Aufbauend auf der ersten Erhebung organisiert der VskA Berlin // Fachverband der Nachbarschaftsarbeit, in Kooperation mit der Senatsverwaltung für Integration, Arbeit und Soziales und der Freiwilligenagentur Marzahn-Hellersdorf, die „Zeit der Solidarität“, in der weitere zahlenmäßige Erfassungen von obdachlosen Menschen durchgeführt und mit einem teilhabeorientierten Prozess verbunden werden. Die zweite Erhebung findet am 22. Juni 2022 statt.', starts_at: '2022-06-22 22:00:00', ends_at: '2022-06-23 02:00:00', user_id: 15)

Counting.create(title: 'Dritte Nacht der Solidarität am 14./15.12.2023', description_short: 'Aufbauend auf der ersten Erhebung organisiert der VskA Berlin // Fachverband der Nachbarschaftsarbeit, in Kooperation mit der Senatsverwaltung für Integration, Arbeit und Soziales und der Freiwilligenagentur Marzahn-Hellersdorf, die „Zeit der Solidarität“, in der weitere zahlenmäßige Erfassungen von obdachlosen Menschen durchgeführt und mit einem teilhabeorientierten Prozess verbunden werden. Die dritte Erhebung ist für den Winter 2023/2024 geplant.', starts_at: '2023-12-14 22:00:00', ends_at: '2023-12-15 02:00:00', user_id: 15)
