--
-- Copyright (c) 2025 by RaiderIO, Inc.
-- All rights reserved.
--
local provider={name=...,data=3,region="eu",date="2025-10-19T06:06:23Z",numCharacters=27,db={}}
local F

F = function() provider.db["Auberdine"]={0,"Agrou","Amelyss","Birbichette","Lomyah","Nylâh","Pinocchio","Pylaf","Shalanore","Shaopao","Ïllythras"} end F()
F = function() provider.db["MirageRaceway"]={20,"Eizon","Fehica","Rawrhehe"} end F()
F = function() provider.db["Hoptallus"]={26,"Ludidoktor"} end F()
F = function() provider.db["Garalon"]={28,"Hresources","Jonmena","Kamarile","Mcfat"} end F()
F = function() provider.db["Norushen"]={36,"Seruss","Tonzil"} end F()

F = nil
RaiderIO.AddProvider(provider)
