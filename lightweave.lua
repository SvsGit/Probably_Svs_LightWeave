-- ProbablyEngine Rotation Packager
-- Custom Mistweaver Monk Rotation
-- Created on Dec 31st 2013 9:16 am
-- Modified on Jan 20th 2014 6:36 pm
-- Version 1.0.6

ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

ProbablyEngine.listener.register('LFG_PROPOSAL_SHOW', AcceptProposal)

ProbablyEngine.rotation.register_custom(270, '|cFF32ff84Svs LightWeave', {

  { '115921', -- Legacy of the Emperor
      {
        '!player.buff(117666).any', -- Legacy of the Emperor
        '!player.buff(1126).any', -- Mark of the Wild
        '!player.buff(90363).any', -- Embrace of the Shale Spider
        '!player.buff(20217).any' -- Blessing of Kings
      }
  },
  
  -- Hotkeys
  { '115313', 'modifier.lshift', 'ground' }, -- Summon Jade Serpent Statue
  { '!115450', 'modifier.lalt', 'mouseover' }, -- Detox Mousever
  
  { '!/targetenemy [noharm]', { '!target.alive', '!target.enemy', '!target.exists' }}, -- Autotarget
  
  -- Interrupt
  { '116705', 'target.interruptAt(80)' }, -- Spear Hand Strike
  
  -- Defensives
  { '115203', 'player.health < 30' }, -- Fortifying Brew
  { '!/run UseItemByName(5512)', 'player.health < 30' }, -- Healthstone
  { '137562', 'player.state.disorient' }, -- Nimble Brew
  { '137562', 'player.state.stun' },
  { '137562', 'player.state.root' },
  { '137562', 'player.state.snare' },
  { '137562', 'player.state.fear' },

  -- Legendary Meta Support
  { '!108557', { 'player.buff(137331)', 'target.spell(108557).range', '!modifier.last' }}, -- Jab
  
  -- Mana management
  { '!100784', { 'player.buff(139597)', 'target.spell(108557).range', 'modifier.multitarget' }}, -- Blackout Kick/Muscle Memory
  { '!100787', { 'player.buff(139597)', 'target.spell(100787).range' }}, -- Tiger Palm/Muscle Memory
  { '123761', { 'player.buff(115867).count >= 2', 'player.mana <= 80' }}, -- Mana Tea
  { '108557', { 'target.spell(108557).range', 'player.mana <= 25', '!modifier.last' }}, -- Jab
  { '#trinket1', 'player.mana < 80' },
  { '#trinket2', 'player.mana < 80' },
    
  { '115080', { -- Touch of Death
    '!target.range > 5',
    'player.buff(121125)' -- Death Note
  }},
  
  -- Mouseover Healing
  {{
  { '115175', { 'mouseover.health < 100', 'mouseover.spell(115175).range' }, 'mouseover' }, -- Soothing Mist 
  }, 'toggle.mouseover' },
    
  { '115310', { -- Revival
  '@coreHealing.needsHealing(70, 4)', 
  }, 'lowest' },
  
  -- Life Cocoon
  { '116849', 'tank.health < 30', 'tank' },
  { '116849', 'lowest.health < 20', 'lowest' },
  
  { '116680', '@coreHealing.needsHealing(85, 3)' }, -- Thunder Focus Tea
  
  -- Uplift
  { '!116670', { 'player.chi >= 2', '@coreHealing.needsHealing(70, 4)' }, nil },
  { '116670', { 'player.chi >= 5' }, nil },
  
  {{
  { '116847' },  -- Rushing Jade Wind
  { '101546' },  -- Spinning Crane Kick
  }, 'modifier.multitarget' },
  
  -- Cooldowns
  {{
  { '#gloves' },
  { '/run CastSpellByID(121279)', 'player.spell(121279).cooldown < 1', 'player' }, -- Lifeblood, thanks to Mavmins and Backburn
  { '123904', '@coreHealing.needsHealing(70, 4)' }, -- Invoke Xuen, the White Tiger
  }, 'modifier.cooldowns' },

  { '115151', { 'tank.health < 99', 'tank.spell(115151).range' }, 'tank' }, -- Renewing Mist
  { '115151', { 'lowest.health < 99', '!lowest.buff(119611)', 'lowest.spell(115151).range' }, 'lowest' }, -- Renewing Mist
  { '115151', 'player.chi < 5' }, -- Renewing Mist
  
  { '115098', { 'lowest.health < 90', 'lowest.spell(115098).range' }, 'lowest'}, -- Chi Wave
  
  { '115399', { '!player.buff(137331)', '!player.buff(139597)', '!modifier.last' }}, -- Chi Brew
  
  { '115072', { -- Expel Harm
    'player.health < 80',
    '!player.buff(137331)',
  }},
  
  { '108557', { 'player.chi < 1', 'target.spell(108557).range' }}, -- Jab
  
  { '100784', { '!player.buff(127722)', 'target.spell(108557).range' }}, -- Blackout Kick/Serpent's Zeal
  { '100784', { 'player.buff(127722).duration <= 2', 'target.spell(108557).range' }}, -- Blackout Kick/Serpent's Zeal
  
  { '100787', { '!player.buff(125359)', 'target.spell(108557).range' } }, -- Tiger Palm/Tiger Power
  { '100787', { 'player.buff(125359).duration <= 2', 'target.spell(108557).range' }}, -- Tiger Palm/Tiger Power
  
  -- Crackling Jade Lightning
  {{
  { '117952', { 'player.chi < 5', 'target.spell(117952).range', '!player.buff(139597)' }}, 
  { '117952', { 'player.chi < 5', 'target.spell(117952).range', '!player.buff(137331)' }},
  }, '!player.moving' },

  }, {
  
  -- Out of Combat
  { '115921', -- Legacy of the Emperor
      {
        '!player.buff(117666).any', -- Legacy of the Emperor Buff
        '!player.buff(1126).any', -- Mark of the Wild
        '!player.buff(90363).any', -- Embrace of the Shale Spider
        '!player.buff(20217).any' -- Blessing of Kings
      }
  },
  { '115313', 'modifier.lshift', 'ground' }, -- Summon Jade Serpent Statue

  { '115072', 'player.health < 80' }, -- Expel Harm
  
  { '115151', { 'lowest.health < 99', '!lowest.buff(119611)', '!lowest.range > 40' }, 'lowest' }, -- Renewing Mist
  { '115151', 'player.chi < 5' }, -- Renewing Mist

  { '116670', { 'player.chi >= 2', '@coreHealing.needsHealing(60, 4)' }, nil }, -- Uplift
  
  { '115450', 'modifier.lalt', 'mouseover' }, -- Detox Mousever

},  function()
ProbablyEngine.toggle.create('mouseover', 'Interface\\Icons\\ability_monk_soothingmists', 'Mouseover Healing', 'Toggle Mouseover Healing For SoO')
end)
