
// Create a global variabled called 'led' and assign the 'pin9' object to it
// The <- is Squirrel’s way of creating a global variable and assigning its initial value
led <- hardware.pin9;

// Configure 'led' to be a digital output with a starting value of digital 0 (low, 0V)
led.configure(DIGITAL_OUT, 0);

// Function called to turn the LED on or off
// according to the value passed in (1 = on, 0 = off)
function setLedState(state) {
    server.log("Set LED to state: " + state);
    led.write(state);
}

// Register a handler for incoming "set.led" messages from the agent
agent.on("set.led", setLedState);