
// Create a global variabled called 'led' and assign the 'pin9' object to it
// The <- is Squirrel’s way of creating a global variable and assigning its initial value
button <- hardware.pin1;
led <- hardware.pin9;
lightUp <- 0;
// Configure 'led' to be a digital output with a starting value of digital 0 (low, 0V)
led.configure(DIGITAL_OUT, 0);

// Function called to turn the LED on or off
// according to the value passed in (1 = on, 0 = off)
function setLedState(state) {
    server.log("Set LED to state: " + state);
    lightUp = state;
    led.write(state);
    agent.send("lightUp", lightUp);
}

// Register a handler for incoming "set.led" messages from the agent
agent.on("set.led", setLedState);

function buttonPress() {

  local state = button.read();

  if (state == 1) {
      // The button is released
      server.log("Release");
  } else {
      // The button is pressed
      server.log("Press");
      if (lightUp == 0) {
        lightUp = 1;
      } else {
        lightUp = 0;
      }
  }
  led.write(lightUp);
}

// Configure the button to call buttonPress() when the pin's state changes
button.configure(DIGITAL_IN_PULLUP, buttonPress);
