local settings = UT.getSettings()

if not settings.skillPoints then
    do return end
end

_G.CloneClass(SkillTreeManager)
function SkillTreeManager:_verify_loaded_data(...)
    SkillTreeManager.orig._verify_loaded_data(self, settings.skillPoints - managers.experience:current_level())
end