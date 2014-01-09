-- ProbablyEngine Rotation Packager
-- Custom Mistweaver Monk Rotation
-- Created on Dec 31st 2013 9:16 am
-- Version 1.0.3

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
  { '115313', 'modifier.lshift', 'ground' }, -- Summon Jade Serpent Statue
  
  { '115450', 'modifier.lalt', 'mouseover' }, -- Detox Mousever
  
  { '!/targetenemy [noharm]', { '!target.alive', '!target.enemy', '!target.exists', }}, -- Autotarget
  
  { '115203', 'player.health < 30' }, -- Fortifying Brew
  
  -- Interrupt
  { '116705', 'modifier.interrupts' }, -- Spear Hand Strike
  
  { '!/run UseItemByName(5512)', 'player.health < 30' }, -- Healthstone
  
  { '137562', 'player.state.disorient' }, -- Nimble Brew
  { '137562', 'player.state.stun' },
  { '137562', 'player.state.root' },
  { '137562', 'player.state.snare' },
  { '137562', 'player.state.fear  ' },
  
  { '121279', 'spell.exists' }, -- Lifeblood
  { '#gloves' }, 
  
  { '123761', { 'player.buff(115867).count >= 2', 'player.mana <= 80' }}, -- Mana Tea
  
  { '115080', { -- Touch of Death
    '!target.range > 5',
    'player.buff(121125)' -- Death Note
  }},
  
  -- Mouseover Healing
  { '115175', { 'toggle.mouseover', 'mouseover.health < 100', '!mouseover.range > 40' }, 'mouseover' }, -- Soothing Mist
  { '124682', { 'toggle.mouseover', 'player.casting(115175)', 'mouseover.health < 80', '!mouseover.range > 40' }, nil}, -- Enveloping Mist

  -- CJL Stopcasting?
  
  { '115310', { -- Revival
  '@coreHealing.needsHealing(39, 4)', 
  '!lowest.range > 40'
  }, 'lowest' },
  
  -- Life Cocoon
  { '116849', 'tank.health < 30', 'tank' },
  { '116849', 'lowest.health < 20', 'lowest' },
  
  { '116680', '@coreHealing.needsHealing(85, 3)' }, -- Thunder Focus Tea
  
  -- Uplift
  { '116670', { 'player.chi >= 2', '@coreHealing.needsHealing(60, 4)' }, nil },
  { '116670', { 'player.chi >= 5' }, nil }, -- , '@coreHealing.needsHealing(90, 3)'
  
  { '116847', { 'player.mana > 50', 'player.chi < 4', '@coreHealing.needsHealing(60, 4)' }, nil },  -- Rushing Jade Wind
  
  { '123904', '@coreHealing.needsHealing(50, 4)' }, -- Invoke Xuen, the White Tiger
  
  { '115151', { 'tank.health < 99', 'tank.spell(115151).range' }, 'tank' }, -- Renewing Mist
  { '115151', 'player.chi < 5' }, -- Renewing Mist
  { '115151', { 'lowest.health < 99', '!lowest.buff(119611)', 'lowest.spell(115151).range' }, 'lowest' }, -- Renewing Mist
  
  { '115098', { '!player.buff(137331)', '!player.buff(139597)' }}, -- Chi Wave
  
  { '115399', { '!player.buff(137331)', '!player.buff(139597)' }}, -- Chi Brew
  
  { '115072', { -- Expel Harm
    'player.health < 80',
    '!player.buff(137331)',
  }},
  
  { '108557', { 'player.buff(137331)', '!player.buff(139597)', 'target.spell(108557).range' }}, -- Jab
  { '108557', { 'player.buff(137331)', 'player.buff(139597)', 'player.chi < 1', 'target.spell(108557).range' }}, -- Jab
  
  { '100784', { '!player.buff(127722)', '!target.range > 5' }}, -- Blackout Kick/Serpent's Zeal
  { '100784', { 'player.buff(127722).duration <= 2', '!target.range > 5' }}, -- Blackout Kick/Serpent's Zeal
  
  { '100787', { '!player.buff(125359)', '!target.range > 5' } }, -- Tiger Palm/Tiger Power
  { '100787', { 'player.buff(125359).duration <= 2', '!target.range > 5' }}, -- Tiger Palm/Tiger Power
  
  -- Crackling Jade Lightning
  {{
  { '117952', { 'player.chi < 5', 'target.spell(117952).range', '!player.buff(139597)' }}, 
  { '117952', { 'player.chi < 5', 'target.spell(117952).range', '!player.buff(137331)' }},
  { '117952', { 'player.chi < 5', 'target.spell(117952).range' }},
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
  
  { '115151', { 'lowest.health < 99', '!lowest.buff(119611)', '!lowest.range > 40' }, 'lowest' }, -- Renewing Mist
  { '115151', 'player.chi < 5' }, -- Renewing Mist
  
  { '115450', 'modifier.lalt', 'mouseover' }, -- Detox Mousever

},  function()
ProbablyEngine.toggle.create('mouseover', 'Interface\\Icons\\ability_monk_soothingmists', 'Mouseover Healing', 'Toggle Mouseover Healing For SoO')
end)
