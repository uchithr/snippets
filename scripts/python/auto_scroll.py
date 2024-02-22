import pyautogui
import time

SCROLL_DELAY = 0.01
SCROLL_UNITS = 30

while True:
    pyautogui.scroll(-SCROLL_UNITS)
    time.sleep(SCROLL_DELAY)
