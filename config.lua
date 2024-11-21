Config = {}

Config.PoliceJobs = { --jobs required to be a k9
    'police',
    'k9',
    -- add unlimited
}

-- item name, label (Label is shown the the k9 if found, if you want to catagorize, just make all drugs "drugs", or exploisves "exposives" whatever), 
-- chance the dog actually finds the item (a skill based system will be coming soon (if enough interest))
-- Weapons are case sensitive, use all upper case
Config.SearchableItems = { -- items that when a K9 searches will be found
    { name = 'WEAPON_STICKYBOMB', label = 'Explosive Weapon...', chance = 50 },
    { name = 'meth', label = 'Illegal Drugs', chance = 50 },
    -- add unlimited
}

Config.BigDogs = { -- Your Large K9 Ped Names
    "a_c_chop",
    "a_c_husky",
    "a_c_retriever",
    "a_c_shepherd",
    "a_c_rottweiler",
    -- add unlimited
}

Config.SmallDogs = { -- Your Small K9 Ped Names
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

Config.k9ActivateCommand = 'k9activate' -- The command for the player to use to be able to use k9 menu
Config.k9MenuCommand = 'k9menu' -- Command to open K9 menu

Config.Lang = {
    -- General notifications
    ['vehicle_restriction'] = 'You cannot activate the K9 from inside a vehicle.',
    ['k9_mode_activated'] = 'K9 mode activated. Use /k9menu to access features.',
    ['no_players_nearby'] = 'No players nearby.',
    ['no_vehicles_nearby'] = 'No vehicles nearby.',
    ['searching_player'] = 'K9 Searching Player...',
    ['searching_vehicle'] = 'K9 Searching Vehicle...',
    
    -- K9 menu options
    ['enter_exit_vehicle'] = 'Command the K9 to enter or exit a nearby vehicle.',
    ['search_player'] = 'Order the K9 to search the closest player for contraband.',
    ['search_vehicle'] = 'Command the K9 to search a nearby vehicle.',
    ['access_sounds'] = 'Access various K9 sound effects.',
    
    -- K9 sound notifications
    ['play_sound'] = 'Play the sound: ',
    
    -- K9 search actions
    ['k9_found_contraband'] = 'K9 found contraband: ',
    ['k9_found_nothing'] = 'K9 found nothing.',
    
    -- Errors
    ['error_message'] = 'An error occurred. Please try again later.',
    ['vehicle_too_far'] = 'The vehicle is too far away to search.',
    ['access_denied'] = 'Access Denied',
    ['k9_no_valid_role'] = 'You must be a member of the police department to access this command.',
}

-- Also check server/main.lua to add your active K9 webhook!!!!!