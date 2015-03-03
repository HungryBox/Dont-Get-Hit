require 'gosu'
require './Color'

module Dev
  EnemyCount = 5

  EscapeLag = 3

  PlayerVelocity = 3
  PlayerInertiaX = 0.50
  PlayerInertiaY = 0.50
  PlayerShotLag = 30 #ms
  PlayerBulletSpeed = -4
  PlayerHitBox = 10

  CoinVelocity = 2
  CoinHitBox = 10

  SimpleEnemyVelocity = 1
  SimpleEnemyShotLag = 100 #ms
  SimpleEnemyAdditionalBulletSpeed = 1
  SimpleEnemyHitBox = 10

  FontName = Gosu::default_font_name
  FontHeight = 45
  FontSize = 20
  LineSpacing = 0
  LineWidth = 248
  TextAlign = :center

  NumberWidth = 50
  NumberHeight = NumberWidth
  NumberLineWidth = NumberWidth

  ButtonColor = Color::BLUE
end
