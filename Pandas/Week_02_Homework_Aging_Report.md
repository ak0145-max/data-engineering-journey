# Week 2 Homework — Accounts Receivable Aging Report
## Session 3 & 4: Pandas Fundamentals + Data Cleaning

**Modern Data Engineering Course** — Week 2  
**Total Marks: 100**  
**Due: Before Session 5**  
**Submission: Upload your `.ipynb` notebook file**

---

## 📦 Dataset

**File:** `invoices_bd.csv`  
**Download:** Available in the course materials folder

### About the Dataset:
This dataset contains **200+ invoices** from a Bangladeshi company. Each row is one invoice with the following columns:

| Column | Description |
|---|---|
| `invoice_id` | Unique invoice number |
| `customer_name` | Company or person name |
| `invoice_date` | When the invoice was issued |
| `due_date` | When payment was due |
| `amount_bdt` | Invoice amount in BDT (Taka) |
| `paid_amount_bdt` | How much has been paid so far |
| `status` | "Paid", "Partial", or "Unpaid" |
| `payment_date` | Date of payment (blank if unpaid) |
| `category` | Business category |
| `city` | Customer city |

The dataset intentionally has some real-world messiness — missing values, duplicates, inconsistent text — that you'll need to clean before building the report.

---

## 🎯 What You're Building

An **Accounts Receivable (AR) Aging Report** — one of the most common reports in any business. It shows which customers owe money, how much, and how overdue each invoice is.

Every company — from a small shop in Motijheel to a multinational — needs this report. Finance teams use it to decide who to follow up with and when to escalate collections.

### What is an Aging Report?

An aging report groups unpaid invoices into buckets based on how many days overdue they are:

| Bucket | Meaning |
|---|---|
| **Current** | 0–30 days — still within payment terms |
| **31–60 days** | Slightly overdue — send a reminder |
| **61–90 days** | Significantly overdue — escalate |
| **90+ days** | Severely overdue — risk of bad debt |

By the end of this homework, you'll generate a report that looks like this:

```
Customer     Current    31-60 Days   61-90 Days   90+ Days    Total
Rahim Ltd    45,000     30,000       0            0           75,000
Fatima Corp  0          25,000       50,000       0           75,000
Karim & Co   0          0            0            60,000      60,000
```

---

## 📝 Tasks

---

### Part 1: Load & Explore (10 points)

**Task 1.1 — Load the Data (3 points)**
- Import `pandas` and `numpy`
- Load `invoices_bd.csv` into a DataFrame called `df`
- Print the first 5 rows

**Task 1.2 — Explore (7 points)**
- Print shape, column names, and data types
- Run `df.info()` and `df.describe()`
- Add a comment answering:
  - *How many invoices are in the dataset?*
  - *What data types need fixing?*
  - *Are there any null values?*

---

### Part 2: Data Cleaning (25 points)

**Task 2.1 — Handle Missing Values (7 points)**
- Check nulls with `df.isnull().sum()`
- `payment_date` will have nulls — that's expected (unpaid invoices have no payment date). Leave these as-is.
- For any other columns with nulls, decide whether to fill or drop and explain your reasoning in a comment

**Task 2.2 — Remove Duplicates (5 points)**
- Check for duplicate `invoice_id` values
- Remove duplicates, keeping the first occurrence
- Print how many rows were removed

**Task 2.3 — Fix Data Types (8 points)**
- Convert `invoice_date`, `due_date`, and `payment_date` to datetime using `pd.to_datetime(errors="coerce")`
- Convert `amount_bdt` and `paid_amount_bdt` to numeric using `pd.to_numeric(errors="coerce")`
- Verify with `df.dtypes`

**Task 2.4 — Standardize Strings (5 points)**
- Strip whitespace from all string columns
- Standardize `customer_name` to title case (`.str.strip().str.title()`)
- Check `df["city"].unique()` — fix any inconsistencies (e.g. "dhaka" vs "Dhaka")

---

### Part 3: Build the Aging Report (35 points)

**Task 3.1 — Filter Unpaid Invoices (5 points)**
- Filter the DataFrame to keep only rows where `status` is "Unpaid" or "Partial"
- Store in `df_outstanding`
- Print how many outstanding invoices exist

**Task 3.2 — Calculate Outstanding Balance (5 points)**
- Create a column `outstanding_bdt` = `amount_bdt` - `paid_amount_bdt`
- For fully unpaid invoices, `paid_amount_bdt` might be 0 or NaN — handle this:
  ```python
  df_outstanding["paid_amount_bdt"] = df_outstanding["paid_amount_bdt"].fillna(0)
  ```

**Task 3.3 — Calculate Days Overdue (10 points)**
- Calculate how many days each invoice is overdue:
  ```python
  today = pd.Timestamp.today().normalize()
  df_outstanding["days_overdue"] = (today - df_outstanding["due_date"]).dt.days
  ```
- Negative values mean the invoice isn't overdue yet — set those to 0:
  ```python
  df_outstanding["days_overdue"] = df_outstanding["days_overdue"].clip(lower=0)
  ```

**Task 3.4 — Create Aging Buckets (10 points)**
- Create a column `aging_bucket` based on `days_overdue`:
  - 0–30 days → "Current"
  - 31–60 days → "31-60 Days"
  - 61–90 days → "61-90 Days"
  - 90+ days → "90+ Days"

> 💡 **Hint:**
> ```python
> conditions = [
>     df_outstanding["days_overdue"] <= 30,
>     df_outstanding["days_overdue"] <= 60,
>     df_outstanding["days_overdue"] <= 90,
> ]
> choices = ["Current", "31-60 Days", "61-90 Days"]
> df_outstanding["aging_bucket"] = np.select(conditions, choices, default="90+ Days")
> ```

- Print `value_counts()` of `aging_bucket`

**Task 3.5 — Pivot the Aging Report (5 points)**
- Create the final aging report using `pivot_table`:
  ```python
  aging_report = df_outstanding.pivot_table(
      index="customer_name",
      columns="aging_bucket",
      values="outstanding_bdt",
      aggfunc="sum",
      fill_value=0
  )
  ```
- Add a `Total` column: `aging_report["Total"] = aging_report.sum(axis=1)`
- Sort by `Total` descending
- Print the full report

---

### Part 4: Analysis & Export (20 points)

**Task 4.1 — Summary Statistics (5 points)**
- Print the total outstanding amount across all customers
- Print the average outstanding amount per customer
- Print how many customers have invoices in the "90+ Days" bucket

**Task 4.2 — City-wise Aging (5 points)**
- Group `df_outstanding` by `city` and calculate total outstanding per city
- Which city has the highest outstanding amount? Add a comment with your answer.

**Task 4.3 — Top Debtors (5 points)**
- Show the top 5 customers with the highest total outstanding amount
- Add a comment: *If you were the finance manager, which customer would you call first and why?*

**Task 4.4 — Export (5 points)**
- Export the aging report (pivot table) to `aging_report.csv`
- Export `df_outstanding` (the full cleaned data) to `outstanding_invoices.csv`
- Use `index=True` for the pivot table (customer names are the index)

---

## ✅ Grading Rubric

| Section | Topic | Points |
|---|---|---|
| Part 1 | Load & Explore | 10 |
| Part 2 | Data Cleaning | 25 |
| Part 3 | Build Aging Report | 35 |
| Part 4 | Analysis & Export | 20 |
| **Total** | | **100** |

### Grading Criteria:
- **Code correctness** — does it run without errors and produce the right output?
- **Cleaning quality** — did you handle nulls, duplicates, types, and strings properly?
- **Comments & explanations** — did you explain your decisions (especially in Part 2)?
- **Output** — did you print results for each task so we can see them?

---

## 🎁 Bonus Challenge (Up to 10 extra points)

1. **(3 points)** Create a bar chart showing outstanding amount by aging bucket using:
   ```python
   aging_report.drop(columns="Total").sum().plot(kind="bar", title="Aging Summary")
   ```
   (install matplotlib if needed: `pip install matplotlib`)

2. **(3 points)** Calculate the **weighted average days overdue** per customer (weight by outstanding amount)

3. **(4 points)** Add a `risk_level` column: customers with >50% of their outstanding in "90+ Days" are "High Risk", otherwise "Normal". How many high-risk customers are there?

---

## 📌 Submission Guidelines

1. **File name:** `week2_hw_[your_name].ipynb`
2. **Format:** Jupyter Notebook (`.ipynb`)
3. **Structure your notebook clearly:**
   - Use markdown cells for section headers (Part 1, Part 2, etc.)
   - Add comments explaining what each code block does
   - Print outputs for each task so we can see results
4. **Upload directly** — do not share Google Drive or Colab links
5. **Generated CSV files** are NOT required to submit — just the notebook

---

## ⚠️ Important Notes

- **Do NOT use AI tools** to generate the entire notebook. Use them to understand concepts if needed, but write the code yourself.
- Every technique in this homework was covered in **Session 3 and Session 4** — revisit the class notebooks if you're stuck.
- **Ask questions** in the group — if you're stuck, others probably are too!

---

*This is a real report that finance teams generate every month. Add it to your portfolio — it shows employers you can build practical business tools with Python.* 🚀
