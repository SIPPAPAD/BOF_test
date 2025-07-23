const { test, expect } = require('@playwright/test');

const BASE_URL = 'https://sit-uplifestyle-admin.thailife.com';
const USERNAME = 'saranyapong.tar@thailife.com';
const PASSWORD = 'P@ssword1';

test.describe.configure({ timeout: 120000 }); // Suite timeout

test.beforeEach(async ({ page }) => {
  await loginToSystem(page);
});

test.afterEach(async ({ page }) => {
  await page.close();
});

async function loginToSystem(page) {
  await page.goto(BASE_URL);
  await page.waitForSelector('text=Welcome Back', { timeout: 30000 });
  await page.click('text=Sign in >> nth=1');
  await page.waitForTimeout(2000);

  if (await page.isVisible('text=Pick an account')) {
    await page.click('text=Saranyapong Tarama');
  }

  if (await page.waitForSelector('input[placeholder="Email, phone, or Skype"]')){
    await page.fill('input[placeholder="Email, phone, or Skype"]', USERNAME);
    await page.click('text=Next');
  }

  if (await page.isVisible('input[type="password"]')) {
    await page.fill('input[type="password"]', PASSWORD);
    await page.click('input[value="Sign in"]');
  }

  if (await page.waitForSelector('text=Stay signed in?', { timeout: 10000 })){
    await page.getByRole('button', { name: 'Yes' }).click();
  }

  await page.waitForSelector('text=UP Lifestyle Backoffice', { timeout: 30000 });
}

async function clickMenuIfNeeded(page, menu, submenu) {
  const isVisible = await page.isVisible(`text=${submenu}`);
  if (!isVisible) {
    await page.click(`text=${menu}`);
    await page.waitForTimeout(1000);
  }
}

test('Content Management - Manage Feeds', async ({ page }) => {
  await clickMenuIfNeeded(page, 'Content Management', 'Manage Feeds');
  await page.click('text=Manage Feeds');
  const heading = await page.textContent('//div[text()="Manage Feeds"]');
  expect(heading).toBe('Manage Feeds');
});

test('Content Management - Manage Banner', async ({ page }) => {
  await clickMenuIfNeeded(page, 'Content Management', 'Manage Banner');
  await page.click('text=Manage Banner');
  const heading = await page.textContent('//div[text()="Manage Banner"]');
  expect(heading).toBe('Manage Banner');
});

test('Content Management - Manage Quote', async ({ page }) => {
  await clickMenuIfNeeded(page, 'Content Management', 'Manage Quote');
  await page.click('text=Manage Quote');
  const heading = await page.textContent('//div[text()="Manage Quote"]');
  expect(heading).toBe('Manage Quote');
});

test('Content Management - Manage Popup', async ({ page }) => {
  await clickMenuIfNeeded(page, 'Content Management', 'Manage Popup');
  await page.click('text=Manage Popup');
  await page.waitForLoadState('networkidle');
  await page.waitForSelector('text=Manage Popup', { timeout: 30000 });
  const heading = await page.textContent('text=Manage Popup');
  expect(heading).toBe('Manage Popup');
});

test('Log Monitoring - Admin Activity Log', async ({ page }) => {
  await clickMenuIfNeeded(page, 'Log Monitoring', 'Admin Activity Log');
  await page.click('text=Admin Activity Log');
  const heading = await page.textContent('//div[text()="Admin Activity Log"]');
  expect(heading).toBe('Admin Activity Log');
});

test('Customer Management - Application User Info', async ({ page }) => {
  await clickMenuIfNeeded(page, 'Customer Management', 'Application User Information');
  await page.click('text=Application User Information');
  const heading = await page.textContent('//div[text()="Application User Info"]');
  expect(heading).toBe('Application User Info');
});

test('System Configuration - Manage Role & Permission', async ({ page }) => {
  await clickMenuIfNeeded(page, 'System Configuration', 'Manage Role & Permission');
  await page.click('text=Manage Role & Permission');
  const heading = await page.textContent('//div[text()="Manage Roles and Permissions"]');
  expect(heading).toBe('Manage Roles and Permissions');
});
