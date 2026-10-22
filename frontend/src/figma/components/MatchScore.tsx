interface MatchScoreProps {
  score: number;
  size?: "sm" | "md" | "lg";
}

export default function MatchScore({ score, size = "md" }: MatchScoreProps) {
  const r = size === "lg" ? 42 : size === "md" ? 30 : 22;
  const stroke = size === "lg" ? 6 : 5;
  const circumference = 2 * Math.PI * r;
  const offset = circumference - (score / 100) * circumference;
  const dim = (r + stroke) * 2;

  const color =
    score >= 85 ? "#29A66A" : score >= 70 ? "#176B45" : score >= 50 ? "#f59e0b" : "#ef4444";

  const textSize =
    size === "lg" ? "text-xl font-bold" : size === "md" ? "text-sm font-bold" : "text-xs font-semibold";

  return (
    <div className="relative inline-flex items-center justify-center">
      <svg width={dim} height={dim} style={{ transform: "rotate(-90deg)" }}>
        <circle
          cx={dim / 2}
          cy={dim / 2}
          r={r}
          fill="none"
          stroke="#E2F5EC"
          strokeWidth={stroke}
        />
        <circle
          cx={dim / 2}
          cy={dim / 2}
          r={r}
          fill="none"
          stroke={color}
          strokeWidth={stroke}
          strokeLinecap="round"
          strokeDasharray={circumference}
          strokeDashoffset={offset}
          style={{ transition: "stroke-dashoffset 0.6s ease" }}
        />
      </svg>
      <span
        className={`absolute ${textSize}`}
        style={{ color }}
      >
        {score}%
      </span>
    </div>
  );
}
