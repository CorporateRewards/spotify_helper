phrases = BannedPhrases.create(
    [
        { phrase: "admin" }, { phrase: "god" }, { phrase: "omnipotent" }, { phrase: "omniscient" }, { phrase: "nazi" }, { phrase: "hitler" }
    ]
)

# Create admin user
Admin.create(email: 'gill@createk.io', password: 'password')
User.create(email: 'gill@createk.io', password: 'password', first_name: 'gill', last_name: 'manning')
