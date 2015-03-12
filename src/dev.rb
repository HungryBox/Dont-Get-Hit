require 'gosu'
require './Color'

module Dev
  EnemyCount = 50

  EscapeLag = 0

  MouseEnabled = true

  FinishDuration = 3000 #ms

  PlayerVelocity = 3
  PlayerInertiaX = 0.50
  PlayerInertiaY = 0.50
  PlayerShotLag =  3*10 #ms
  PlayerBulletSpeed = -5
  PlayerHitBox = 10

  CoinVelocity = 1
  CoinHitBox = 10
  CoinValue = 10

  SimpleEnemyVelocity = 1 #1
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
