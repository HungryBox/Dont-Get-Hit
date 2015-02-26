require 'gosu'

module Dev
  EscapeLag = 3

  PlayerVelocity = 3
  PlayerInertiaX = 0.50
  PlayerInertiaY = 0.50
  PlayerShotLag = 10 #ms
  PlayerBulletSpeed = -2
  PlayerHitBox = 5

  SimpleEnemyVelocity = 1
  SimpleEnemyShotLag = 40 #ms
  SimpleEnemyAdditionalBulletSpeed = 1
  SimpleEnemyHitBox = 10

  FontName = Gosu::default_font_name
  FontHeight = 50
  FontSize = 50
end
