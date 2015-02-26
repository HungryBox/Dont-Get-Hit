require 'gosu'

module Dev
  PlayerVelocity = 3
  PlayerInertiaX = 0.50
  PlayerInertiaY = 0.50
  PlayerShotLag = 1
  PlayerBulletSpeed = -2
  PlayerHitBox = 5

  SimpleEnemyVelocity = 1
  SimpleEnemyShotLag = 4
  SimpleEnemyAdditionalBulletSpeed = 1
  SimpleEnemyHitBox = 10

  FontName = Gosu::default_font_name
  FontHeight = 20
  FontSize = 20
end
