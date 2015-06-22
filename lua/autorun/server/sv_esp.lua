surface.CreateFont("aesp_font", {
   font = "Arial",
   size = 15,
   weight = 50,
   antialias = true
})

local ESP = CreateClientConVar("admin_esp", "0" , true, false)
local ESP_d = CreateClientConVar("esp_d", "999999", true, false)


local function DrawText(strText, oCol, iXPos, iYPos)
   draw.SimpleTextOutlined(strText, "aesp_font", iXPos, iYPos, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
end

local function DrawAdminESP()
   if(!LocalPlayer():IsSuperAdmin()) then return; end
   if(ESP:GetInt() < 1) then return; end

   for k, v in pairs(player.GetAll()) do
      if (v == LocalPlayer()) then
         continue
      end
      
      if(LocalPlayer():GetPos():Distance(v:GetPos()) < ESP_d:GetInt()) then
         local Pos = (v:GetPos() + Vector(0, 0, 50)):ToScreen()
         
         DrawText("Name: "..v:Nick(),               team.GetColor(v:Team()),   Pos.x, Pos.y + 13 * 0)
         DrawText("SteamID: "..v:SteamID(),            Color(255, 255, 255, 255), Pos.x, Pos.y + 13 * 1)
         DrawText("Ping: "..v:Ping(),             Color(255, 255, 255, 255), Pos.x, Pos.y + 13 * 2)
         DrawText("Group: "..v:GetNWString("usergroup"), Color(255, 255, 255, 255), Pos.x, Pos.y + 13 * 3)
         DrawText("Job: "..team.GetName(v:Team()), Color(255, 255, 255, 255), Pos.x, Pos.y + 13 * 4)
         DrawText("$"..v:getDarkRPVar("money"), Color(255, 255, 255, 255), Pos.x, Pos.y + 13 * 5)
      end
   end
end
hook.Add("HUDPaint", "DrawAdminESP", DrawAdminESP)