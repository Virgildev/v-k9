Config = {}

Config.PoliceJobs = { --jobs required to be a k9
    'police',
    'k9',
    -- add unlimited
}

Config.SearchableItems = { -- items that when a K9 searches will be found
    -- item name, label (Label is shown the the k9 if found, if you want to catagorize, just make all drugs "drugs", or exploisves "exposives" whatever)
    { name = 'weapon_stickybomb', label = 'Explosive Weapon...' },
    { name = 'meth', label = 'Illegal Drugs' },
    -- add unlimited
}

Config.BigDogs = { -- Your Large Dog Ped Names
    "a_c_chop",
    "a_c_husky",
    "a_c_retriever",
    "a_c_shepherd",
    "a_c_rottweiler",
    -- add unlimited
}

Config.SmallDogs = { -- Your Small Dog Ped Names
    "a_c_poodle",
    "a_c_pug",
    "a_c_westy",
    -- add unlimited
}

-- Separate sounds and emotes for small and large dogs
Config.SmallDogSounds = {
    -- label in menu, sound it makes (through interact-sounds), emote with it
    { label = 'Small Dog Toy', sound = 'dog-toy', emote = 'sdogtennis' },
    { label = 'Small Dog Bark', sound = 'small-dog-mean-bark', emote = 'sdogbark' },
    { label = 'Small Dog Whine', sound = 'large-dog-whin', emote = 'sdogld' },
    -- add unlimited
}

Config.LargeDogSounds = {
    { label = 'Large Dog Toy', sound = 'large-dog-mean-bark', emote = 'bdogbark' },
    { label = 'German Shepherd Whine', sound = 'large-dog-whin', emote = 'bdogbeg' },
    { label = 'Big Dog Toy', sound = 'dog-toy', emote = 'bdogfris' },
    -- add unlimited
}
