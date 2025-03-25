// .github/actions/hello-world-action/index.js
const core = require('@actions/core');

try {
  // Input parameter for custom message
  const message = core.getInput('message');
  console.log(`Hello, ${message}!`);
} catch (error) {
  core.setFailed(`Action failed with error: ${error.message}`);
}
