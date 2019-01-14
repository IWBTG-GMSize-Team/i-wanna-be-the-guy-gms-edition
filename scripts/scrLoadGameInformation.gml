///scrLoadGameInformation(onlyBackground)
///loads the game information from savedata.
///argument0 - sets whether or not to read the save file when loading the game

//only load save data from the save file if the script is currently set to (we should only need to load these on first load because the game stores them afterwards)

{
    var onlyBackground = argument0;
    
    //load the save map
    var saveMap;
    
    if (global.extraSaveProtection) //use ds_map_secure function
    {
        saveMap = ds_map_secure_load("Data\save"+string(global.savenum));
    }
    else    //use text file
    {
        var f = file_text_open_read("Data\save"+string(global.savenum));
        
        saveMap = json_decode(base64_decode(file_text_read_string(f)));
        
        file_text_close(f);
    }
    
    var saveValid = true;   //keeps track of whether or not the save being loaded is valid
    
    if (saveMap != -1)  //check if the save map loaded correctly
    {
        if (onlyBackground)
        {
            global.savedBackgroundIndex = ds_map_find_value(saveMap, "backgroundIndex");
            ds_map_destroy(saveMap);
            return 0;
        }
        global.death = ds_map_find_value(saveMap,"death");
        global.time = ds_map_find_value(saveMap,"time");
        global.timeMicro = ds_map_find_value(saveMap,"timeMicro");
        
        global.difficulty = ds_map_find_value(saveMap,"difficulty");
        global.saveRoom = ds_map_find_value(saveMap,"saveRoom");
        global.savePlayerX = ds_map_find_value(saveMap,"savePlayerX");
        global.savePlayerY = ds_map_find_value(saveMap,"savePlayerY");
        global.saveGrav = ds_map_find_value(saveMap,"saveGrav");
        
        global.savedBackgroundIndex = ds_map_find_value(saveMap, "backgroundIndex");
        
        
        if (is_string(global.saveRoom))   //check if the saved room loaded properly
        {
            if (!room_exists(asset_get_index(global.saveRoom)))  //check if the room index in the save is valid
                saveValid = false;
        }
        else
        {
            saveValid = false;
        }
        
        for (var i = 0; i < global.secretItemTotal; i++)
        {
            global.saveSecretItem[i] = ds_map_find_value(saveMap,"saveSecretItem["+string(i)+"]");
        }
        
        for (var i = 0; i < global.bossItemTotal; i++)
        {
            global.saveBossItem[i] = ds_map_find_value(saveMap,"saveBossItem["+string(i)+"]");
        }
        
        global.saveGameClear = ds_map_find_value(saveMap,"saveGameClear");
        
        ds_map_destroy(saveMap);
        
        return 0;
    }
    else
    {
        return -1;
    }
}

        
    
    
