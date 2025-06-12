const africastalking = require('africastalking')({ apiKey, username });
const axios = require('axios');

app.post('/ussd', async (req, res) => {
  const { text, phoneNumber } = req.body;
  const userId = ethers.utils.keccak256(ethers.utils.toUtf8Bytes(phoneNumber));

  if (text === '') {
    res.send("CON Welcome to ZySwap\n1. Send Tokens\n2. Check Balance\n3. My Wallet Info");
  } else if (text === '1') {
    res.send("CON Enter amount:");
  } else if (text.startsWith('1*')) {
    const [_, amount] = text.split('*');
    res.send("CON Enter recipient address:");
  } else if (text.split('*').length === 3) {
    const [_, amount, recipient] = text.split('*');
    await axios.post('http://localhost:3000/send', {
      userId,
      tokenAddress: '<cUSD_TOKEN_ADDRESS>',
      recipient,
      amount
    });
    res.send("END Transaction sent. Check status in a few minutes.");
  } else if (text === '2') {
    const response = await axios.post('http://localhost:3000/balance', {
      userId,
      tokenAddress: '<cUSD_TOKEN_ADDRESS>'
    });
    res.send(`END Your cUSD balance is ${response.data.balance}`);
  } else if (text === '3') {
    const response = await axios.post('http://localhost:3000/wallet-info', { userId });
    res.send(`END Your wallet address is ${response.data.walletAddress}`);
  }
});
