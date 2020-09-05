String CARD_TOTAL_TEXT,
       CARD_TOTAL_TEXT_BUST,
       BET_TEXT,
       TOTAL_MONEY_TEXT,
       CPU_CARD_TOTAL_TEXT,
       WINNER_ANNOUNCE_TEXT,
       WINNER_PLAYER_TEXT,
       WINNER_CPU_TEXT,
       LOSE_TEXT,
       BUTTON_HIT_LABEL,
       BUTTON_SIT_LABEL,
       BUTTON_DOUBLE_LABEL,
       BUTTON_SPLIT_LABEL,
       START_GAME_TEXT,
       OPTIONS_TEXT,
       START_GARFIELF_TEXT,
       CONTROLS_TEXT;

void loadText()
{
  try {
    //GAME_TITLE           = xml.getAsString("GAME_TITLE");
    CARD_TOTAL_TEXT      = xml.getAsString("CARD_TOTAL_TEXT");
    CARD_TOTAL_TEXT_BUST = xml.getAsString("CARD_TOTAL_TEXT_BUST");
    BET_TEXT             = xml.getAsString("BET_TEXT");
    TOTAL_MONEY_TEXT     = xml.getAsString("TOTAL_MONEY_TEXT");
    CPU_CARD_TOTAL_TEXT  = xml.getAsString("CPU_CARD_TOTAL_TEXT");
    WINNER_ANNOUNCE_TEXT = xml.getAsString("WINNER_ANNOUNCE_TEXT");
    WINNER_PLAYER_TEXT   = xml.getAsString("WINNER_PLAYER_TEXT");
    WINNER_CPU_TEXT      = xml.getAsString("WINNER_CPU_TEXT");
    LOSE_TEXT            = xml.getAsString("LOSE_TEXT");
    BUTTON_HIT_LABEL     = xml.getAsString("BUTTON_HIT_LABEL");
    BUTTON_SIT_LABEL     = xml.getAsString("BUTTON_SIT_LABEL");
    BUTTON_DOUBLE_LABEL  = xml.getAsString("BUTTON_DOUBLE_LABEL");
    BUTTON_SPLIT_LABEL   = xml.getAsString("BUTTON_SPLIT_LABEL");
    START_GAME_TEXT      = xml.getAsString("START_GAME_TEXT");
    OPTIONS_TEXT         = xml.getAsString("OPTIONS_TEXT");
    START_GARFIELF_TEXT  = xml.getAsString("START_GARFIELF_TEXT");
    CONTROLS_TEXT        = xml.getAsString("CONTROLS_TEXT");
    CONTROLS_TEXT = CONTROLS_TEXT.replace("\\n", "\n");
  }catch (Exception e) {
    errorScreen(e);
  }
  
}
