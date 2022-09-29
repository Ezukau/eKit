Config = {}

Webhook = "https://discord.com/api/webhooks/1025080168680788110/bx37oRHnrNTMFEuG7yQjh9LnGgnTM4p2xmHOuFySiqVXx6tK6DydVsyRSvrjxZCUBx9j"

Config = {
    CouleurMenu = "y", -- r = rouge, b = bleu, o = orande, p = violet, y = jaune, g = vert

    Item = true, -- true pour mettres les items / false pour mettre ne pas les mettre
    ListeItem = {

        {name = "bread",nombre = 25},
        {name = "pied_biche", nombre = 2},
    },

    Argent = true, -- true pour mettres l'argent / false pour mettre ne pas l'argent
    ListeArgent = {

        {type = "cash", nombre = 15000},
        {type = "bank", nombre = 25645},
        {type = "black_money", nombre = 456464},
    },

    Armes = true, -- true pour mettres les armes / false pour mettre ne pas les armes
    ListeArmes = {

        {weapon = "weapon_pistol"},
        {weapon = "weapon_pistol50"},
        {weapon = "weapon_assaultrifle"},
    },


    --### PEDS
    ActivePeds = true, -- Mettre les peds (true = activer/false = desactiver)
    HashPed = "a_f_m_beach_01",
    PositionPed = {
        {pos = vector3(-1005.287, -2746.367, 13.75 - 1), heading = 157.40},
    },


    --### BLIPS
    ActiveBlips = true, -- Mettre les blips (true = activer/false = desactiver)
    PositionBlips = {
        {pos = vector3(-1005.287, -2746.367, 13.75)},
    },
    Blips = {
        Name = "Kit",
        Taille = 0.7,
        Id = 133,
        Couleur = 11,
        Range = true,
    },


}

