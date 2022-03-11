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

# ---------------------------------------------------------------------------
# Defined content for encounter responses
# ---------------------------------------------------------------------------
Gender.insert_all([
                    { label_de: 'Weiblich', label_en: 'Female' },
                    { label_de: 'Männlich', label_en: 'Male' },
                    { label_de: 'Inter/divers', label_en: 'Diverse' }
                  ])

AgeGroup.insert_all([
                      { min_age: 0, max_age: 13 },
                      { min_age: 14, max_age: 17 },
                      { min_age: 18, max_age: 20 },
                      { min_age: 21, max_age: 24 },
                      { min_age: 25, max_age: 26 },
                      { min_age: 27, max_age: 29 },
                      { min_age: 30, max_age: 39 },
                      { min_age: 40, max_age: 49 },
                      { min_age: 50, max_age: 64 },
                      { min_age: 65, max_age: nil }
                    ])
