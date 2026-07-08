#TASK 1: Variables & Data Types


pipeline = input("Pipeline name: ")
total = int(input("Total rows: "))
failed = int(input("Failed rows: "))
time_sec = float(input("Run time (seconds): "))

success = total - failed
success_rate = success / total *100
duration_min = time_sec / 60
throughpout = total / time_sec

if success_rate >= 98:
    status = "HEALTHY"
elif success_rate >= 95:
    status = "WARNING"
else:
    status = "CRITICAL"

print("\n" + "=" * 50)
print(f" PIPLINE: {pipeline}")
print(f" STATUS: {success_rate: .1f}%")
print(f" THROUHPUT {throughpout: .0f} rows/sec")
print("=" * 50)

