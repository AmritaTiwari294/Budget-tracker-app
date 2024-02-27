const { Firestore } = require('@google-cloud/firestore');
const firestore = new Firestore();

// GET /expenses - Retrieve all expenses
app.get('/expenses', async (req, res) => {
  try {
    const snapshot = await firestore.collection('expenses').get();
    const expenses = snapshot.docs.map(doc => doc.data());
    res.json(expenses);
  } catch (error) {
    console.error('Error getting expenses:', error);
    res.status(500).send('Internal Server Error');
  }
});

// POST /expense - Add a new expense
app.post('/expense', async (req, res) => {
  try {
    const expenseData = req.body;
    const docRef = await firestore.collection('expenses').add(expenseData);
    const newExpense = await docRef.get();
    res.json(newExpense.data());
  } catch (error) {
    console.error('Error adding expense:', error);
    res.status(500).send('Internal Server Error');
  }
});

// PUT /expense/:id - Update an existing expense
app.put('/expense/:id', async (req, res) => {
  try {
    const id = req.params.id;
    const expenseData = req.body;
    await firestore.collection('expenses').doc(id).set(expenseData, { merge: true });
    res.json({ message: 'Expense updated successfully' });
  } catch (error) {
    console.error('Error updating expense:', error);
    res.status(500).send('Internal Server Error');
  }
});

// DELETE /expense/:id - Delete an expense
app.delete('/expense/:id', async (req, res) => {
  try {
    const id = req.params.id;
    await firestore.collection('expenses').doc(id).delete();
    res.json({ message: 'Expense deleted successfully' });
  } catch (error) {
    console.error('Error deleting expense:', error);
    res.status(500).send('Internal Server Error');
  }
});
